<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>YedamBNB</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <header class="py-3">
                <h1>YedamBNB Project</h1>
                <hr>
            </header>

            <main>
                <tiles:insertAttribute name="body" />
            </main>

            <footer class="py-3 mt-4">
                <hr>
                <p class="text-center text-muted">&copy; 2025 YedamBNB</p>
            </footer>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    </html>