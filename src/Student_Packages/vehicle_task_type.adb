-- Suggestions for packages which might be useful:
with Ada.Real_Time;              use Ada.Real_Time;
with Ada.Text_IO;                use Ada.Text_IO;
with Exceptions;                 use Exceptions;
with Real_Type;                  use Real_Type;
with Vectors_3D;                 use Vectors_3D;
with Vehicle_Interface;          use Vehicle_Interface;
with Swarm_Structures_Base; use Swarm_Structures_Base;
with Vehicle_Message_Type;       use Vehicle_Message_Type;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;
with Swarm_Configuration;  use Swarm_Configuration;

package body Vehicle_Task_Type is

   task body Vehicle_Task is
       type Coordinate is record
         X_axis : Real;
         Y_axis : Real;
         Z_axis : Real;
       end record;

      type motivation is (Charging, Queue_for_charging, Roaming, Die);
      --  type vehicle_decision is record
      --     Rush_to_globe : Boolean;
      --     Roaming_near_globe
      --
      local_ivm : Inter_Vehicle_Messages;
      replaced_ivm : Inter_Vehicle_Messages;  -- A local variable to stores inter vehicle messages when it needs to update
      Vehicle_No : Positive;
      Globe_Coordinate : Coordinate;
      -- 3d coordinate of globe

      Local_time : Time := Clock; -- timestamp
      Constant_Theta : constant Long_Float := Long_Float (Initial_No_of_Elements) / Long_Float (2); -- it makes model beautiful
      Vehicle_Destination : Vector_3D;

      Vehicle_Angle : Long_Float;

      Charging_Throttle : constant Throttle_T := 0.8; -- full throttle will consume more energy, less throttle can be stable
      Roaming_Throttle : constant Throttle_T := 0.5;

      -- Vehicle Find globe is to determine whether they find globes and if they do, they send messages.
      procedure Globe_Detection is
         -- Send message out if vehicle find any globes.
      begin
         if Energy_Globes_Around'Length > 0 then
            for ix in Energy_Globes_Around'Range loop
               local_ivm.Globe_Position := Energy_Globes_Around (ix).Position;
               local_ivm.Vehicle_Clock := Clock;
               Send (local_ivm);
            end loop;
         end if;
      end Globe_Detection;

      function More_Than_Four_Want_Charge (arr : Array_Boolean) return Boolean is
         -- four is most suitable after testing manually
         count : Natural := 0;
      begin
         for i in arr'Range loop
            if arr (i) then
               count := count + 1;
            end if;
         end loop;

         -- Release the waiting charing vehicles together when more than 4
         -- vehicle needs to charge and let them go to charge
         if count < 4 then
            return False;

         end if;
         return True;
      end More_Than_Four_Want_Charge;

      function is_low_energy (f : Vehicle_Charges) return Boolean is
      begin
            if f < 0.6 then
               replaced_ivm.Vehicle_Want_To_Charge (Vehicle_No) := True;
               return True;
            end if;
            return False;
      end is_low_energy;
      procedure send_latest_message is
      begin
         -- Send replaced message and update clock
         Send (replaced_ivm);
         local_ivm.Vehicle_Clock := Local_time;

      end send_latest_message;
      procedure assign_track (m : motivation) is
      begin
         case m is

            when Charging =>
                 replaced_ivm.Vehicle_Want_To_Charge (Vehicle_No) := True;
                Set_Destination (replaced_ivm.Globe_Position);
               Set_Throttle (Charging_Throttle);
               when Queue_for_charging =>
                replaced_ivm.Vehicle_Want_To_Charge (Vehicle_No) := True;
               Vehicle_Destination := (Globe_Coordinate.X_axis +  0.1 * Real (Sin (Float (Vehicle_Angle))),
                                       Globe_Coordinate.Y_axis + 0.1 * Real (Cos (Float (Vehicle_Angle))), Globe_Coordinate.Z_axis);
                Set_Destination (Vehicle_Destination);
                Set_Throttle (Roaming_Throttle);

            when Roaming =>
                replaced_ivm.Vehicle_Want_To_Charge (Vehicle_No) := False;
               Vehicle_Destination := (Globe_Coordinate.X_axis +  0.2 * Real (Sin (Float (Vehicle_Angle))),
                                       Globe_Coordinate.Y_axis + 0.2 * Real (Cos (Float (Vehicle_Angle))), Globe_Coordinate.Z_axis);
                Set_Destination (Vehicle_Destination);
               Set_Throttle (Roaming_Throttle);

            when Die =>
               Vehicle_Destination := (Globe_Coordinate.X_axis +  0.4 * Real (Sin (Float (Vehicle_Angle))),
                                       Globe_Coordinate.Y_axis + 0.4 * Real (Cos (Float (Vehicle_Angle))), Globe_Coordinate.Z_axis);
                Set_Destination (Vehicle_Destination);
               Set_Throttle (Roaming_Throttle);
         end case;
         Vehicle_Angle := (Vehicle_Angle + Pi / Constant_Theta); -- Make vehicle drive in a track of sphere
         -- Send origin message and update new direction of vehicle
         Send (local_ivm);
      end assign_track;

   begin

      -- You need to react to this call and provide your task_id.
      -- You can e.g. employ the assigned vehicle number (Vehicle_No)
      -- in communications with other vehicles.

      accept Identify (Set_Vehicle_No : Positive; Local_Task_Id : out Task_Id) do
         Vehicle_No     := Set_Vehicle_No;
         Local_Task_Id  := Current_Task;
      end Identify;

      -- Replace the rest of this task with your own code.
      -- Maybe synchronizing on an external event clock like "Wait_For_Next_Physics_Update",
      -- yet you can synchronize on e.g. the real-time clock as well.

      -- Without control this vehicle will go for its natural swarming instinct.

      select

         Flight_Termination.Stop;

      then abort
         -- Initialize the vehicle theta.
         Vehicle_Angle :=  Constant_Theta * (Long_Float (Vehicle_No));
         --  Check initallization
         --  Put_Line (Long_Float'Image(Long_Float (Vehicle_No) * Constant_Delta_Theta));
         Outer_task_loop : loop

            Wait_For_Next_Physics_Update;
            -- Your vehicle should respond to the world here: sense, listen, talk, act?

            Globe_Detection;

            if not Messages_Waiting then
               Globe_Detection;
            else
               Receive (local_ivm);
              -- Update message if it is not latest
               if Local_time > local_ivm.Vehicle_Clock then
                  send_latest_message;
               else
                  Local_time := local_ivm.Vehicle_Clock;
                  replaced_ivm := local_ivm;
                  -- add vehicles to surviving set if it not fullfilled yet
                  if replaced_ivm.survive_count > 0 then
                     if not replaced_ivm.Vehicle_To_Survive (Vehicle_No) then
                        replaced_ivm.Vehicle_To_Survive (Vehicle_No) := True;
                           replaced_ivm.survive_count := replaced_ivm.survive_count - 1;
                     end if;
                  end if;

                  -- seperate cooridinate of globe to assign conveniently
                  Globe_Coordinate.X_axis := replaced_ivm.Globe_Position (x);
                  Globe_Coordinate.Y_axis := replaced_ivm.Globe_Position (y);
                  Globe_Coordinate.Z_axis := replaced_ivm.Globe_Position (z);

                  -- Set destination of vehicles which choose to die
                  if not replaced_ivm.Vehicle_To_Survive (Vehicle_No) then
                     assign_track (Die);
                  else

                     if is_low_energy (Current_Charge) then
                        -- Vehicle_Have_Been_Charge is an attribute of whether the vehicle wants to charge has charged.
                        -- otherwise roaming around globe with different radius

                        if More_Than_Four_Want_Charge (replaced_ivm.Vehicle_Want_To_Charge) then
                           assign_track (Charging);
                        else
                            assign_track (Queue_for_charging);
                        end if;
                     else
                        assign_track (Roaming);
                     end if;
                  end if;

               end if;
            end if;
         end loop Outer_task_loop;
      end select;
   exception
      when E : others => Show_Exception (E);

   end Vehicle_Task;

end Vehicle_Task_Type;
