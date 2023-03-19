const pickerOpts = {
    types: [
        {
            description: 'HoneStorages',
            accept: {
                'application/json': ['.hs']
            }
        },
    ]
};

function isFilePickAvailable() {
    return window.showOpenFilePicker instanceof Function;
}

async function pickFile() {
    const [handle] = await window.showOpenFilePicker(pickerOpts);
    return handle;
}

async function loadFile(handle) {
    return await (await handle.getFile()).arrayBuffer();
}

async function syncFile(handle, data) {
    const writableStream = await handle.createWritable();
    await writableStream.write(data);
    await writableStream.close();
}
