
CREATE OR REPLACE FUNCTION notify_spec_data_change()
RETURNS TRIGGER AS $$
DECLARE
  changed_fields text[];
  old_json jsonb;
  new_json jsonb;
  primary_key_data jsonb;
  payload jsonb;
BEGIN
  IF TG_OP = 'UPDATE' THEN
    old_json := to_jsonb(OLD);
    new_json := to_jsonb(NEW);
    -- Get changed column names
    SELECT array_agg(key) INTO changed_fields
    FROM jsonb_object_keys(new_json) AS key
    WHERE (old_json->key) IS DISTINCT FROM (new_json->key);
    primary_key_data := jsonb_build_object('id', NEW._id); -- Assuming 'id' is PK
  ELSIF TG_OP = 'DELETE' THEN
    old_json := to_jsonb(OLD);
    new_json := NULL;
    primary_key_data := jsonb_build_object('id', OLD._id); -- Assuming 'id' is PK
  ELSE -- INSERT
    old_json := NULL;
    new_json := to_jsonb(NEW);
    primary_key_data := jsonb_build_object('id', NEW._id); -- Assuming 'id' is PK
  END IF;

  payload := jsonb_build_object(
    'timestamp', now()::text,
    'operation', TG_OP,
    'schema', TG_TABLE_SCHEMA,
    'table', TG_TABLE_NAME,
    'data', CASE WHEN TG_OP = 'DELETE' THEN old_json ELSE new_json END,
    'primaryKeyData', primary_key_data,
    'columnNamesChanged', CASE WHEN TG_OP = 'UPDATE' THEN changed_fields ELSE NULL END
  );

  PERFORM pg_notify('spec_data_change', payload::text);

  RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;
$$ LANGUAGE plpgsql;

-- Example Triggers (using the 'spec_data_change' function)
-- You would create specific triggers for each table you want to monitor.

DROP TRIGGER IF EXISTS user_change_trigger ON "user";
CREATE TRIGGER user_change_trigger
AFTER INSERT OR UPDATE OR DELETE ON "user"
FOR EACH ROW EXECUTE FUNCTION notify_spec_data_change();

-- DROP TRIGGER IF EXISTS profile_change_trigger ON "user_profiles";
-- CREATE TRIGGER profile_change_trigger
-- AFTER INSERT OR UPDATE OR DELETE ON "user_profiles"
-- FOR EACH ROW EXECUTE FUNCTION notify_spec_data_change();

-- -- Add more triggers for other tables as needed:
-- DROP TRIGGER IF EXISTS transaction_change_trigger ON "transactions";
-- CREATE TRIGGER transaction_change_trigger
-- AFTER INSERT OR UPDATE OR DELETE ON "transactions"
-- FOR EACH ROW EXECUTE FUNCTION notify_spec_data_change();