#!/usr/bin/env nextflow

params.str = "Nextflow provides an abstraction layer between your pipelines logic and the execution layer, so that it can be executed on multiple platforms without it changing."

process splitLetters {

    output:
    file 'chunk_*' into letters

    """
    printf '${params.str}' | split -b 6 - chunk_
    """
}


process convertToUpper {

    input:
    file x from letters.flatten()

    output:
    stdout result

    """
    // cat $x | tr '[a-z]' '[A-Z]'
    sleep 10s
    rev $x
    """
}

result.view { it.trim() }
