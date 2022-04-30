# shellcheck shell=sh
# Create Base Directories
mkdir -p  $XDG_CONFIG_HOME  \
          $XDG_CACHE_HOME  \
          $XDG_LOCAL_HOME  \
          $XDG_DATA_HOME  \
          $XDG_STATE_HOME  \
          $XDG_BIN_HOME 

# Create User Directories
mkdir -p  $XDG_DOCUMENTS_DIR  \
          $XDG_DOWNLOADS_DIR  \
          $XDG_VIDEOS_DIR  \
          $XDG_WORK_DIR  \
          $XDG_DATA_DIR  \
          $XDG_RECORDINGS_DIR  \
          $XDG_SCREENSHOTS_DIR 
