module env

import v.embed_file { EmbedFileData }

pub struct Env {
    pub:
        file EmbedFileData

    mut:
        cached map[string]string
}

pub fn (mut environment Env) get(key string) ?string {
    // Return from cache if exists
    if value := environment.cached[key] {
        return value
    }

    // Parse line by line looking for key
    content := environment.file.to_string()
    lines := content.split_into_lines()
    for line in lines {
        if line.starts_with('#') || !line.contains('=') {
            continue
        }

        parts := line.split('=')
        if parts[0].trim_space() == key {
            value := parts[1].trim_space().trim('"')
            environment.cached[key] = value // Cache for next time
            return value
        }
    }

    return none
}
