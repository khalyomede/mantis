module database

import db.sqlite
import console

pub struct Database {
    pub:
        connection DatabaseConnection
        connections map[string]DatabaseConnection
    mut:
        handle sqlite.DB
        handles map[string]sqlite.DB
}

pub fn (mut db Database) get_connection() !sqlite.DB {
    if !db.handle.is_open {
        db.handle = sqlite.connect(db.connection.database)!
    }

    return db.handle
}

pub fn (mut db Database) close() ! {
    // Closing default connection
    if db.handle.is_open {
        db.handle.close()!
    }

    // Closing named connections
    for _, mut handle in db.handles {
        if handle.is_open {
            handle.close()!
        }
    }

    db.handles.clear()
}

pub fn (mut db Database) run(query string) ! {
    conn := db.get_connection()!

    conn.exec(query)!
}

pub fn (mut db Database) all[T](query string) ![]T {
    conn := db.get_connection()!

    // Execute query and map results
    rows := conn.exec(query)!
    mut results := []T{}

    for row in rows {
        mut instance := T{}
        mut index := 0
        // Iterate through struct fields, assuming same order as query
        $for field in T.fields {
            value := row.vals[index]
            $if field.typ is string {
                instance.$(field.name) = value
            } $else $if field.typ is int {
                instance.$(field.name) = value.int()
            } $else $if field.typ is u64 {
                instance.$(field.name) = value.u64()
            }

            index = index + 1
        }
        results << instance
    }

    return results
}

pub fn (db Database) exec(query string) ! {
    mut connection_name := ''
    for name, conn in db.connections {
        if conn.by_default {
            connection_name = name
            break
        }
    }

    if connection_name == '' {
        return error('No default database connection configured')
    }

    connection := db.connections[connection_name] or {
        return error('Database connection "${connection_name}" not found')
    }

    mut sqlite_conn := sqlite.connect(connection.database)!

    defer {
        sqlite_conn.close() or {
            /**
             * @todo Use app.report(err) instead.
             */
            console.error("Could not close Sqlite connection (${err.msg()}).")
        }
    }

    sqlite_conn.exec(query)!
}
