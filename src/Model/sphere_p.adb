--
 -- Jan & Uwe R. Zimmer, Australia, July 2011
 --

with GL, GL.Materials, GLOBE_3D.Math;

package body Sphere_P is
   -- Pretty output: FALSE
   use GL, GL.Materials, GLOBE_3D, GLOBE_3D.Math;

   -- begin Separator # 1
   -- VRML: [# triangle mesh
   -- ]

   matos_1 : constant Material_type := (
                                        ambient =>   (0.0, 0.0, 0.0, 1.0),
                                        specular =>  (0.0, 0.0, 0.0, 1.0),
                                        diffuse =>   (1.0, 1.0, 1.0, 1.0),
                                        emission =>  (0.0, 0.0, 0.0, 1.0),
                                        shininess => 128.0
                                       );
   coord_1 : constant Point_3D_array :=
     ((0.0, 0.0, -1.0), -- VRML: [# coord point    0
      -- ]
      (0.382683, 0.0, -0.92388), (0.707107, 0.0, -0.707107), (0.92388, 0.0, -0.382683), (1.0, 0.0, -0.0),
      (0.92388, 0.0, 0.382683), (0.707107, 0.0, 0.707107), (0.382683, 0.0, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0),
      (0.353553, 0.146447, -0.92388), (0.653282, 0.270598, -0.707107), (0.853553, 0.353553, -0.382683), (0.92388, 0.382683, -0.0), (0.853553, 0.353553, 0.382683),
      (0.653282, 0.270598, 0.707107), (0.353553, 0.146447, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (0.270598, 0.270598, -0.92388),
      (0.5, 0.5, -0.707107), (0.653282, 0.653282, -0.382683), (0.707107, 0.707107, -0.0), (0.653282, 0.653282, 0.382683), (0.5, 0.5, 0.707107),
      (0.270598, 0.270598, 0.92388), -- VRML: [# coord point   25
      -- ]
      (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (0.146447, 0.353553, -0.92388), (0.270598, 0.653282, -0.707107),
      (0.353553, 0.853553, -0.382683), (0.382683, 0.92388, -0.0), (0.353553, 0.853553, 0.382683), (0.270598, 0.653282, 0.707107), (0.146447, 0.353553, 0.92388),
      (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (0.0, 0.382683, -0.92388), (0.0, 0.707107, -0.707107), (0.0, 0.92388, -0.382683),
      (0.0, 1.0, -0.0), (0.0, 0.92388, 0.382683), (0.0, 0.707107, 0.707107), (0.0, 0.382683, 0.92388), (0.0, 0.0, 1.0),
      (0.0, 0.0, -1.0), (-0.146447, 0.353553, -0.92388), (-0.270598, 0.653282, -0.707107), (-0.353553, 0.853553, -0.382683), (-0.382683, 0.92388, -0.0),
      (-0.353553, 0.853553, 0.382683), -- VRML: [# coord point   50
      -- ]
      (-0.270598, 0.653282, 0.707107), (-0.146447, 0.353553, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0),
      (-0.270598, 0.270598, -0.92388), (-0.5, 0.5, -0.707107), (-0.653282, 0.653282, -0.382683), (-0.707107, 0.707107, -0.0), (-0.653282, 0.653282, 0.382683),
      (-0.5, 0.5, 0.707107), (-0.270598, 0.270598, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (-0.353553, 0.146447, -0.92388),
      (-0.653282, 0.270598, -0.707107), (-0.853553, 0.353553, -0.382683), (-0.92388, 0.382683, -0.0), (-0.853553, 0.353553, 0.382683), (-0.653282, 0.270598, 0.707107),
      (-0.353553, 0.146447, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (-0.382683, 0.0, -0.92388), (-0.707107, 0.0, -0.707107),
      (-0.92388, 0.0, -0.382683), -- VRML: [# coord point   75
      -- ]
      (-1.0, 0.0, -0.0), (-0.92388, 0.0, 0.382683), (-0.707107, 0.0, 0.707107), (-0.382683, 0.0, 0.92388),
      (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (-0.353553, -0.146447, -0.92388), (-0.653282, -0.270598, -0.707107), (-0.853553, -0.353553, -0.382683),
      (-0.92388, -0.382683, -0.0), (-0.853553, -0.353553, 0.382683), (-0.653282, -0.270598, 0.707107), (-0.353553, -0.146447, 0.92388), (0.0, 0.0, 1.0),
      (0.0, 0.0, -1.0), (-0.270598, -0.270598, -0.92388), (-0.5, -0.5, -0.707107), (-0.653282, -0.653282, -0.382683), (-0.707107, -0.707107, -0.0),
      (-0.653282, -0.653282, 0.382683), (-0.5, -0.5, 0.707107), (-0.270598, -0.270598, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0),
      (-0.146447, -0.353553, -0.92388), -- VRML: [# coord point  100
      -- ]
      (-0.270598, -0.653282, -0.707107), (-0.353553, -0.853553, -0.382683), (-0.382683, -0.92388, -0.0), (-0.353553, -0.853553, 0.382683),
      (-0.270598, -0.653282, 0.707107), (-0.146447, -0.353553, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (-0.0, -0.382683, -0.92388),
      (-0.0, -0.707107, -0.707107), (-0.0, -0.92388, -0.382683), (-0.0, -1.0, -0.0), (-0.0, -0.92388, 0.382683), (-0.0, -0.707107, 0.707107),
      (-0.0, -0.382683, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0), (0.146447, -0.353553, -0.92388), (0.270598, -0.653282, -0.707107),
      (0.353553, -0.853553, -0.382683), (0.382683, -0.92388, -0.0), (0.353553, -0.853553, 0.382683), (0.270598, -0.653282, 0.707107), (0.146447, -0.353553, 0.92388),
      (0.0, 0.0, 1.0), -- VRML: [# coord point  125
      -- ]
      (0.0, 0.0, -1.0), (0.270598, -0.270598, -0.92388), (0.5, -0.5, -0.707107), (0.653282, -0.653282, -0.382683),
      (0.707107, -0.707107, -0.0), (0.653282, -0.653282, 0.382683), (0.5, -0.5, 0.707107), (0.270598, -0.270598, 0.92388), (0.0, 0.0, 1.0),
      (0.0, 0.0, -1.0), (0.353553, -0.146447, -0.92388), (0.653282, -0.270598, -0.707107), (0.853553, -0.353553, -0.382683), (0.92388, -0.382683, -0.0),
      (0.853553, -0.353553, 0.382683), (0.653282, -0.270598, 0.707107), (0.353553, -0.146447, 0.92388), (0.0, 0.0, 1.0), (0.0, 0.0, -1.0),
      (0.382683, 0.0, -0.92388), (0.707107, 0.0, -0.707107), (0.92388, 0.0, -0.382683), (1.0, 0.0, -0.0), (0.92388, 0.0, 0.382683),
      (0.707107, 0.0, 0.707107), -- VRML: [# coord point  150
      -- ]
      (0.382683, 0.0, 0.92388), (0.0, 0.0, 1.0)  --  153
     );
   -- VRML: [# 153 vertices
   -- ]
   -- begin Separator # 2
   -- VRML: [#triangle mesh
   -- ]

   idx_2 : constant Idx_4_array_array :=
     ((11, 2, 1, 0), -- VRML: [# triangle    0
      -- ]
      (12, 3, 2, 0), (12, 2, 11, 0), (13, 4, 3, 0), (13, 3, 12, 0), (14, 5, 4, 0), (14, 4, 13, 0), (15, 6, 5, 0),
      (15, 5, 14, 0), (16, 7, 6, 0), (16, 6, 15, 0), (17, 8, 7, 0), (17, 7, 16, 0), (18, 8, 17, 0), (20, 11, 10, 0), (21, 12, 11, 0),
      (21, 11, 20, 0), (22, 13, 12, 0), (22, 12, 21, 0), (23, 14, 13, 0), (23, 13, 22, 0), (24, 15, 14, 0), (24, 14, 23, 0), (25, 16, 15, 0),
      (25, 15, 24, 0), (26, 17, 16, 0), -- VRML: [# triangle   25
      -- ]
      (26, 16, 25, 0), (27, 17, 26, 0), (29, 20, 19, 0), (30, 21, 20, 0), (30, 20, 29, 0), (31, 22, 21, 0),
      (31, 21, 30, 0), (32, 23, 22, 0), (32, 22, 31, 0), (33, 24, 23, 0), (33, 23, 32, 0), (34, 25, 24, 0), (34, 24, 33, 0), (35, 26, 25, 0),
      (35, 25, 34, 0), (36, 26, 35, 0), (38, 29, 28, 0), (39, 30, 29, 0), (39, 29, 38, 0), (40, 31, 30, 0), (40, 30, 39, 0), (41, 32, 31, 0),
      (41, 31, 40, 0), (42, 33, 32, 0), (42, 32, 41, 0), -- VRML: [# triangle   50
      -- ]
      (43, 34, 33, 0), (43, 33, 42, 0), (44, 35, 34, 0), (44, 34, 43, 0), (45, 35, 44, 0),
      (47, 38, 37, 0), (48, 39, 38, 0), (48, 38, 47, 0), (49, 40, 39, 0), (49, 39, 48, 0), (50, 41, 40, 0), (50, 40, 49, 0), (51, 42, 41, 0),
      (51, 41, 50, 0), (52, 43, 42, 0), (52, 42, 51, 0), (53, 44, 43, 0), (53, 43, 52, 0), (54, 44, 53, 0), (56, 47, 46, 0), (57, 48, 47, 0),
      (57, 47, 56, 0), (58, 49, 48, 0), (58, 48, 57, 0), (59, 50, 49, 0), -- VRML: [# triangle   75
      -- ]
      (59, 49, 58, 0), (60, 51, 50, 0), (60, 50, 59, 0), (61, 52, 51, 0),
      (61, 51, 60, 0), (62, 53, 52, 0), (62, 52, 61, 0), (63, 53, 62, 0), (65, 56, 55, 0), (66, 57, 56, 0), (66, 56, 65, 0), (67, 58, 57, 0),
      (67, 57, 66, 0), (68, 59, 58, 0), (68, 58, 67, 0), (69, 60, 59, 0), (69, 59, 68, 0), (70, 61, 60, 0), (70, 60, 69, 0), (71, 62, 61, 0),
      (71, 61, 70, 0), (72, 62, 71, 0), (74, 65, 64, 0), (75, 66, 65, 0), (75, 65, 74, 0), -- VRML: [# triangle  100
      -- ]
      (76, 67, 66, 0), (76, 66, 75, 0), (77, 68, 67, 0),
      (77, 67, 76, 0), (78, 69, 68, 0), (78, 68, 77, 0), (79, 70, 69, 0), (79, 69, 78, 0), (80, 71, 70, 0), (80, 70, 79, 0), (81, 71, 80, 0),
      (83, 74, 73, 0), (84, 75, 74, 0), (84, 74, 83, 0), (85, 76, 75, 0), (85, 75, 84, 0), (86, 77, 76, 0), (86, 76, 85, 0), (87, 78, 77, 0),
      (87, 77, 86, 0), (88, 79, 78, 0), (88, 78, 87, 0), (89, 80, 79, 0), (89, 79, 88, 0), (90, 80, 89, 0), -- VRML: [# triangle  125
      -- ]
      (92, 83, 82, 0), (93, 84, 83, 0),
      (93, 83, 92, 0), (94, 85, 84, 0), (94, 84, 93, 0), (95, 86, 85, 0), (95, 85, 94, 0), (96, 87, 86, 0), (96, 86, 95, 0), (97, 88, 87, 0),
      (97, 87, 96, 0), (98, 89, 88, 0), (98, 88, 97, 0), (99, 89, 98, 0), (101, 92, 91, 0), (102, 93, 92, 0), (102, 92, 101, 0), (103, 94, 93, 0),
      (103, 93, 102, 0), (104, 95, 94, 0), (104, 94, 103, 0), (105, 96, 95, 0), (105, 95, 104, 0), (106, 97, 96, 0), (106, 96, 105, 0), -- VRML: [# triangle  150
      -- ]
      (107, 98, 97, 0),
      (107, 97, 106, 0), (108, 98, 107, 0), (110, 101, 100, 0), (111, 102, 101, 0), (111, 101, 110, 0), (112, 103, 102, 0), (112, 102, 111, 0), (113, 104, 103, 0),
      (113, 103, 112, 0), (114, 105, 104, 0), (114, 104, 113, 0), (115, 106, 105, 0), (115, 105, 114, 0), (116, 107, 106, 0), (116, 106, 115, 0), (117, 107, 116, 0),
      (119, 110, 109, 0), (120, 111, 110, 0), (120, 110, 119, 0), (121, 112, 111, 0), (121, 111, 120, 0), (122, 113, 112, 0), (122, 112, 121, 0), (123, 114, 113, 0),
      -- VRML: [# triangle  175
      -- ]
      (123, 113, 122, 0), (124, 115, 114, 0), (124, 114, 123, 0), (125, 116, 115, 0), (125, 115, 124, 0), (126, 116, 125, 0), (128, 119, 118, 0), (129, 120, 119, 0),
      (129, 119, 128, 0), (130, 121, 120, 0), (130, 120, 129, 0), (131, 122, 121, 0), (131, 121, 130, 0), (132, 123, 122, 0), (132, 122, 131, 0), (133, 124, 123, 0),
      (133, 123, 132, 0), (134, 125, 124, 0), (134, 124, 133, 0), (135, 125, 134, 0), (137, 128, 127, 0), (138, 129, 128, 0), (138, 128, 137, 0), (139, 130, 129, 0),
      (139, 129, 138, 0), -- VRML: [# triangle  200
      -- ]
      (140, 131, 130, 0), (140, 130, 139, 0), (141, 132, 131, 0), (141, 131, 140, 0), (142, 133, 132, 0), (142, 132, 141, 0), (143, 134, 133, 0),
      (143, 133, 142, 0), (144, 134, 143, 0), (146, 137, 136, 0), (147, 138, 137, 0), (147, 137, 146, 0), (148, 139, 138, 0), (148, 138, 147, 0), (149, 140, 139, 0),
      (149, 139, 148, 0), (150, 141, 140, 0), (150, 140, 149, 0), (151, 142, 141, 0), (151, 141, 150, 0), (152, 143, 142, 0), (152, 142, 151, 0), (153, 143, 152, 0) --  224
     );
   -- VRML: [# 224 triangles
   -- ]
   -- last index now: 0
   -- end Separator # 2
   -- VRML: [#triangle mesh
   -- ]
   -- last index now: 0
   -- end Separator # 2
   -- VRML: [# triangle mesh
   -- ]

   procedure Create (
                    Object        : in out GLOBE_3D.p_Object_3D;
                    Scale  :        GLOBE_3D.Real;
                    Centre        :        GLOBE_3D.Point_3D
                   )
   is
      face_0 : Face_type; -- takes defaults values
   begin
      Object :=
        new Object_3D (Max_points => 153, Max_faces => 224);
      Object.all.Centre := Centre;
      Set_name (Object.all, "insect_body");
      face_0.skin := material_only;
      face_0.material := VRML_Defaults;
      -- Creating separator # 1
      if Almost_zero (Scale - 1.0) then
         Object.all.Point (1 .. 153) := coord_1;
      else
         for p in 1 .. 153 loop
            Object.all.Point (0 + p) := Scale * coord_1 (p);
         end loop;
      end if;
      face_0.material := matos_1;
      -- Creating separator # 2
      for f in 1 .. 224 loop
         face_0.P := idx_2 (f);
         Object.all.face (0 + f) := face_0;
      end loop;
   end Create;
end Sphere_P;
 -- Converted by Wrl2Ada
