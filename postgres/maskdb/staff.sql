SECURITY LABEL FOR anon ON COLUMN staff.email
IS 'MASKED WITH FUNCTION anon.hash(email)';
