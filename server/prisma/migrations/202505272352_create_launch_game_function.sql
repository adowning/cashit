CREATE OR REPLACE FUNCTION launch_game(game_id uuid) RETURNS TEXT AS $$
DECLARE
    session_id uuid;
BEGIN
    INSERT INTO game_sessions (user_id, game_id, expires_at)
    VALUES (current_user_id(), game_id, NOW() + INTERVAL '1 hour')
    RETURNING id INTO session_id;
    
    RETURN jwt_sign(
        current_setting('app.settings.jwt_secret'),
        json_build_object(
            'session_id', session_id,
            'exp', extract(epoch from NOW() + INTERVAL '1 hour')
        )
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;