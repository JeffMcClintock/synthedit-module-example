cmake_minimum_required(VERSION 3.30)

project(Gain)

# HAS_DSP        — this module processes audio (no custom GUI).
# FORMATS_LIST GMPI — build a SynthEdit module (.gmpi). Add VST3/AU/CLAP here to also
#                  emit standalone plugin formats from the same source.
gmpi_plugin(
    PROJECT_NAME ${PROJECT_NAME}
    HAS_DSP
    FORMATS_LIST GMPI
    SOURCE_FILES
        ${PROJECT_NAME}.cpp
)
