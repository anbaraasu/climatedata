async function startApp() {
    const video = document.getElementById('video');
    const canvas = document.getElementById('canvas');
    const context = canvas.getContext('2d');
    const displayFaceCount = document.getElementById('faceCount');

    // Load the model.
    const model = await blazeface.load();

    // Start video stream
    navigator.mediaDevices.getUserMedia({ video: {} })
        .then((stream) => {
            video.srcObject = stream;
        })
        .catch(err => console.error('Failed to get video stream:', err));

    video.addEventListener('play', async () => {
        canvas.width = video.width;
        canvas.height = video.height;

        // Detect faces periodically
        setInterval(async () => {
            const predictions = await model.estimateFaces(video, false);

            // Clear previous drawings
            context.clearRect(0, 0, canvas.width, canvas.height);

            // Draw predictions
            predictions.forEach(prediction => {
                const start = prediction.topLeft;
                const end = prediction.bottomRight;
                const size = [end[0] - start[0], end[1] - start[1]];

                // Draw the bounding box.
                context.beginPath();
                context.strokeStyle = "green";
                context.lineWidth = 4;
                context.rect(start[0], start[1], size[0], size[1]);
                context.stroke();
            });

            // Display the number of faces detected
            displayFaceCount.textContent = `Faces Detected: ${predictions.length}`;
        }, 100);
    });
}

startApp();