CREATE OR REPLACE FUNCTION public.launch_game(game_id uuid)
RETURNS TEXT AS $$
DECLARE
    session_id uuid;
BEGIN
    INSERT INTO game_sessions (user_id, game_id, expires_at)
    VALUES (auth.uid(), game_id, NOW() + INTERVAL '1 hour')
    RETURNING id INTO session_id;
    
    RETURN sign(
        json_build_object(
            'session_id', session_id,
            'exp', extract(epoch from NOW() + INTERVAL '1 hour')
        ),
        current_setting('app.settings.jwt_secret')
    )::text;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;