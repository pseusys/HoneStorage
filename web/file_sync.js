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

async function pickFile() {
    const [handle] = await window.showOpenFilePicker(pickerOpts);
    return handle;
}

async function pickFile(handle) {
    return await (await handle.getFile()).arrayBuffer();
}

async function syncFile(handle, data) {
    const writableStream = await handle.createWritable();
    await writableStream.write(data);
    await writableStream.close();
}
