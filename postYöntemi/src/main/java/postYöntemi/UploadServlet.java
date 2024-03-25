package postYöntemi;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Dosya yükleme işlemi için upload dizinini belirleme
        String uploadPath = getServletContext().getRealPath("/uploads/"); // Yükleme dizini
        File uploadDir = new File(uploadPath); // Yükleme dizinini temsil eden File nesnesi oluşturma

        // Eğer yükleme dizini yoksa, oluştur
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Gelen dosyaların her birini yükleme dizinine kaydetme
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part); // Dosya adını alma
            part.write(uploadPath + File.separator + fileName); // Dosyayı kaydetme
        }

        // İşlem tamamlandıktan sonra kullanıcıya uyarı mesajı gönderme
        response.setContentType("text/html");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h2>İşlem Tamamlandı</h2>");
        response.getWriter().println("<p>Fotograflar başarıyla yüklendi</p>");
        response.getWriter().println("</body></html>");
    }

    // Dosya adını alma
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}
