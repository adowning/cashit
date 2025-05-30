CREATE OR REPLACE FUNCTION notify_table_change_for_spec_data()
RETURNS TRIGGER AS $$
DECLARE
  changed_fields TEXT[];
  current_record_json JSONB;
  old_record_json JSONB;
  primary_key_value TEXT; -- Assuming 'id' is TEXT or can be cast to TEXT. Adjust if PK is numeric.
  payload JSONB;
BEGIN
  -- Determine the operation and set records accordingly
  IF (TG_OP = 'INSERT') THEN
    current_record_json := to_jsonb(NEW);
    old_record_json := NULL;
    primary_key_value := NEW.id::TEXT; -- Assumes 'id' column exists
    changed_fields := NULL;
  ELSIF (TG_OP = 'UPDATE') THEN
    current_record_json := to_jsonb(NEW);
    old_record_json := to_jsonb(OLD);
    primary_key_value := NEW.id::TEXT; -- Assumes 'id' column exists

    -- Get changed column names
    SELECT array_agg(key)
    INTO changed_fields
    FROM jsonb_object_keys(current_record_json) AS key
    WHERE current_record_json->key IS DISTINCT FROM old_record_json->key;

  ELSIF (TG_OP = 'DELETE') THEN
    current_record_json := NULL; -- For DELETE, 'data' will be the old record
    old_record_json := to_jsonb(OLD);
    primary_key_value := OLD.id::TEXT; -- Assumes 'id' column exists
    changed_fields := NULL;
  END IF;

  -- Construct the payload
  payload := jsonb_build_object(
    'timestamp', now()::TEXT,
    'operation', TG_OP,
    'schema', TG_TABLE_SCHEMA,
    'table', TG_TABLE_NAME,
    'data', CASE WHEN TG_OP = 'DELETE' THEN old_record_json ELSE current_record_json END,
    'primaryKeyData', jsonb_build_object('id', primary_key_value),
    'columnNamesChanged', changed_fields
  );

  -- Send notification
  PERFORM pg_notify('spec_data_change', payload::TEXT);

  -- Return appropriate record for AFTER triggers
  IF (TG_OP = 'DELETE') THEN
    RETURN OLD;
  ELSE
    RETURN NEW;
  END IF;
END;
$$ LANGUAGE plpgsql;

-- Apply the trigger to user_profiles table
DROP TRIGGER IF EXISTS user_profiles_spec_data_change_trigger ON "user_profiles";
CREATE TRIGGER user_profiles_spec_data_change_trigger
AFTER INSERT OR UPDATE OR DELETE ON "user_profiles"
FOR EACH ROW EXECUTE FUNCTION notify_table_change_for_spec_data();

-- Apply the trigger to transactions table
DROP TRIGGER IF EXISTS transactions_spec_data_change_trigger ON "transactions";
CREATE TRIGGER transactions_spec_data_change_trigger
AFTER INSERT OR UPDATE OR DELETE ON "transactions"
FOR EACH ROW EXECUTE FUNCTION notify_table_change_for_spec_data();