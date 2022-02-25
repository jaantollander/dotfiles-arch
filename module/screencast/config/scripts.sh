#!/bin/bash
record() {
    screencast "$XDG_RECORDINGS_DIR/$(date -Is)" --size="1920x1048" --one-step
}
