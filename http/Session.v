module http

import os
import json
import time

pub struct Session {
    pub:
        id string
        driver SessionDriver
        path string
        lifetime u64 = 3600
        sliding bool
}

pub fn (session Session) get(key string) ?string {
    session_file := os.join_path(session.path, "${session.id}.json")

    content := os.read_file(session_file) or { return none }
    session_data := json.decode(SessionData, content) or { return none }

    if time.now().unix() > session_data.expires_at {
        os.rm(session_file) or {}
        return none
    }

    if session.sliding {
        new_session_data := SessionData{
            ...session_data
            expires_at: time.now().unix() + session.lifetime
        }

        os.write_file(session_file, json.encode(new_session_data)) or { return none }
    }

    return session_data.data[key] or { none }
}

pub fn (session Session) set(key string, value string) ! {
    session_file := os.join_path(session.path, "${session.id}.json")

    content := os.read_file(session_file) or {
        return error('Failed to read session file: ${err}')
    }

    session_data := json.decode(SessionData, content) or {
        return error('Failed to decode session data: ${err}')
    }

    new_session_data := SessionData{
        data: {
            ...session_data.data
            key: value
        }
    }

    new_content := json.encode(new_session_data)

    os.write_file(session_file, new_content) or {
        return error('Failed to write session file: ${err}')
    }
}

