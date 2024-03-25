<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Form</title>
<style>
    /* CSS stilleri */
    body {
        font-family: Arial, sans-serif;
        background-color: #0f0f46;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    #upload-container {
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        margin: auto;
        width: 30%;
        height: 30%;
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
    }

    input[type="file"] {
        margin-bottom: 10px;
    }

    progress {
        width: 100%;
        height: 20px;
        margin-bottom: 10px;
    }

    button {
        padding: 10px 20px;
        background-color: #4caf50;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #45a049;
    }
</style>
<script>
// JavaScript fonksiyonu: Dosya yükleme işlemini gerçekleştirir
function uploadFiles() {
    // Dosya giriş alanından seçilen dosyaları al
    var fileInput = document.getElementById('fileInput');
    var files = fileInput.files;
    var formData = new FormData();

    // Seçilen her dosyayı FormData nesnesine ekle
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        formData.append('files', file);
    }

    // XMLHttpRequest nesnesi oluştur
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'UploadServlet', true);

    // Yükleme ilerlemesi güncellendiğinde çalışacak fonksiyonu tanımla
    xhr.upload.onprogress = function(event) {
        var progressBar = document.getElementById('progressBar');
        progressBar.value = (event.loaded / event.total) * 100;
    };

    // Sunucu yanıtı geldiğinde çalışacak fonksiyonu tanımla
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            // Dosya yükleme tamamlandığında kullanıcıya bir uyarı göster
            alert('Dosya yukleme tamamlandi !');
        }
    };

    // FormData nesnesini sunucuya gönder
    xhr.send(formData);
}
</script>
</head>
<body>
<div id="upload-container">
    <!-- Form başlığı -->
    <h2>Fotograf Formu</h2>

    <!-- Dosya yükleme formu -->
    <form enctype="multipart/form-data">
        <!-- Dosya seçim alanı -->
        <input type="file" id="fileInput" name="files" multiple><br>

        <!-- İlerleme çubuğu -->
        <progress id="progressBar" value="0" max="100"></progress><br>

        <!-- Gönder butonu -->
        <button type="button" onclick="uploadFiles()">Gonder</button>
    </form>
</div>
</body>
</html>