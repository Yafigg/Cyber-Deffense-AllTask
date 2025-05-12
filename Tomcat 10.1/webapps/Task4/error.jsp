<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }
        .error-container {
            width: 300px;
            padding: 20px;
            border: 1px solid #f44336;
            border-radius: 5px;
            background-color: #ffebee;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h2>Login Failed</h2>
        <p>Invalid username or password. Please try again.</p>
        <p><a href="login.jsp">Return to login</a></p>
    </div>
</body>
</html>