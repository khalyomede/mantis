import test { expect }
import logging { Log }
import logging.channel { File }
import os

fn test_it_logs_debug_data_on_file() {
    log_file_path := "misc/mantis.log"

    os.rm(log_file_path) or {}

    defer {
        os.rm(log_file_path) or {}
    }

    mut log := Log{
        channel: File{
            path: log_file_path
        }
    }

    log.debug("test") or {
        panic(err)
    }

    content := os.read_file(log_file_path) or { "" }

    // TODO: add assertion to match format "[nanosec] [severity] value"
    expect(content).to_end_with("test")
}
