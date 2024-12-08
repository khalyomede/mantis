import mantis.test { expect }
import mantis.database { Database, DatabaseConnection, DatabaseDriver }

struct Post {
    id int
    title string
    views u64
}

fn test_can_query_all_records() {
    mut db := Database{
        connection: DatabaseConnection{
            by_default: true
            driver: .sqlite
            database: ':memory:'
        }
        connections: {
            'default': DatabaseConnection{
                by_default: true
                driver: .sqlite
                database: ':memory:'
            }
        }
    }
    defer {
        db.close() or { panic(err) }
    }

    db.run('DROP TABLE IF EXISTS posts')!
    db.run('CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, views INTEGER)')!
    db.run("INSERT INTO posts (title, views) VALUES ('First post', 42)")!

    posts := db.all[Post]('SELECT id, title, views FROM posts')!

    expect(posts.len).to_be_equal_to(1)
    expect(posts[0].title).to_be_equal_to('First post')
    expect(posts[0].id).to_be_equal_to(1)
    expect(posts[0].views).to_be_equal_to(42)
}
