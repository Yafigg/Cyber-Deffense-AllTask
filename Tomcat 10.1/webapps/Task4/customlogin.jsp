<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Custom LDAP Login</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .login-container { width: 300px; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 8px; box-sizing: border-box; }
        button { padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
        .error { color: red; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Custom LDAP Login</h2>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        
        <form action="ldapLogin" method="post">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="John Fryer" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="Password123" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>