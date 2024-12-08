module mantis

pub struct Env
{
    mut:
        data map[string]string

    pub:
        path string
}

pub fn (env Env) get(key string) ?string {
    return env.parse()[key] or {
        none
    }
}

fn (env Env) parse() map[string]string {
    if env.data.keys().len > 1 {
        return env.data
    }

    mut data := map[string]string{}

    file := $embed_file(@FILE)

    lines := file.to_string().split_into_lines().map(it.split('='))

    for line in lines {
        name := line[0] or {""}
        value := line[1] or {""}
        clear_value := value.trim('"')

        data[name] = clear_value
    }

    return data
}
