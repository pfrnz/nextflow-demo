#!/usr/bin/env nextflow
// show which python the container is running


process pythonVersion {

    output:
    stdout result

    """
    python --version
    """
}

process pythonInline {

    output:
    stdout result2

    """
    #!/usr/bin/env python
    import sys
    import os
    print('Hello from Python: ', sys.version)
    print('working in:', os.getcwd())
    
    """
}

process pythonFile {
    // maps the current projectDir as an input so that it appears in the docker container
    input:
        path here from workflow.projectDir

    output:
        stdout result3

    """
    #!/usr/bin/env python $here/hello.py
    """
}


// result2.view { it.trim() }
result3.view { it.trim() }
