<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Secure Area</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .welcome { background-color: #dff0d8; padding: 15px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome">
            <h1>Welcome to the Secure Area!</h1>
            <% if (session.getAttribute("username") != null) { %>
                <p>Hello, <%= session.getAttribute("username") %>! You have successfully authenticated.</p>
            <% } else { %>
                <p>You have successfully authenticated.</p>
            <% } %>
        </div>
        
        <p>This page is protected and only accessible to authenticated users with the "user" role.</p>
        
        <p><a href="<%= request.getContextPath() %>/">Return to Home</a></p>
    </div>
</body>
</html>