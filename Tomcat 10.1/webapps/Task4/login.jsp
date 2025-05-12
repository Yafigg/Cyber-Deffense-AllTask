<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .login-container { width: 300px; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 8px; box-sizing: border-box; }
        button { padding: 10px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="j_security_check" method="post">
            <div class="form-group">
                <label for="j_username">Username:</label>
                <input type="text" id="j_username" name="j_username" required>
            </div>
            <div class="form-group">
                <label for="j_password">Password:</label>
                <input type="password" id="j_password" name="j_password" required>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
    
    <!-- Hidden helper text -->
    <div style="margin-top: 20px; color: #666; font-size: 0.8em;">
        <p>Hint: Try with username "John Fryer" and your configured password</p>
    </div>
</body>
</html>