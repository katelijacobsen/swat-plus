-- =====================================================================
-- SWAT+ — lookup data (run after 01_schema.sql)
-- No personal data here: users are created by the app / the admin.
-- =====================================================================

BEGIN;

INSERT INTO status (title) VALUES
  ('pending'), ('approved'), ('declined'), ('completed');

INSERT INTO roles (title) VALUES
  ('admin'), ('coordinator'), ('tutor'), ('lector'), ('student');

-- From the "Policies × Roles" matrix in FigJam
INSERT INTO permissions (title) VALUES
  ('edit_shifts'), ('swap_shifts'), ('add_members'), ('edit_queue'), ('queue_up');

-- Which role gets which permission.
-- The matrix in FigJam has no ticks yet, so this mapping follows the
-- scenario text — adjust it when the matrix is filled in.
INSERT INTO permissions_roles (permission_fk, role_fk)
SELECT p.id, r.id
FROM (VALUES
        ('admin',       'add_members'),
        ('admin',       'edit_shifts'),
        ('admin',       'edit_queue'),
        ('coordinator', 'edit_shifts'),
        ('coordinator', 'swap_shifts'),
        ('coordinator', 'edit_queue'),
        ('tutor',       'swap_shifts'),
        ('tutor',       'edit_queue'),
        ('student',     'queue_up'),
        ('student',     'edit_queue')   -- their own queue entry only (enforced in the app)
     ) AS m(role_title, permission_title)
JOIN roles       r ON r.title = m.role_title
JOIN permissions p ON p.title = m.permission_title;

-- Competences named in the scenario
INSERT INTO competences (title) VALUES
  ('Coding'), ('Design'), ('Git'), ('Figma'), ('VS Code');

COMMIT;
