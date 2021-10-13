-- Suggestions for packages which might be useful:

  with Ada.Real_Time;         use Ada.Real_Time;
  with Vectors_3D;            use Vectors_3D;
  with Swarm_Configuration;  use Swarm_Configuration;
  -- with Real_Type;             use Real_Type;
package Vehicle_Message_Type is

   -- Replace this record definition by what your vehicles need to communicate.

   type Array_Boolean is array (Positive range <>) of Boolean;
   --  type Array_Position is array (Positive range <>) of Vector_3D;

   Amount_Of_Vehicles : constant Positive := Initial_No_of_Elements;

   type Inter_Vehicle_Messages is record
      Vehicle_Clock : Time := Clock;
      Globe_Position :  Vector_3D;
      Vehicle_Want_To_Charge : Array_Boolean (1 .. Amount_Of_Vehicles) := (others => False);
      Vehicle_To_Survive : Array_Boolean (1 .. Amount_Of_Vehicles) := (others => False);
      --  Vehicle_Destination : Array_Position (1 .. Amount_Of_Vehicles);
      survive_count : Natural := Target_No_of_Elements; -- Scheduled amount of surviving object
   end record;
end Vehicle_Message_Type;
