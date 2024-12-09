module env

import v.embed_file { EmbedFileData }

pub struct Env {
    pub:
        file EmbedFileData

    mut:
        cached map[string]string
}

pub fn (mut env Env) get(key string) ?string {
    // Return from cache if exists
    if value := env.cached[key] {
        return value
    }

    // Parse line by line looking for key
    content := env.file.to_string()
    lines := content.split_into_lines()
    for line in lines {
        if line.starts_with('#') || !line.contains('=') {
            continue
        }

        parts := line.split('=')
        if parts[0].trim_space() == key {
            value := parts[1].trim_space().trim('"')
            env.cached[key] = value // Cache for next time
            return value
        }
    }

    return none
}
