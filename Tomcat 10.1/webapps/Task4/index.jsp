<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LDAP Authentication Example</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .btn { 
            display: inline-block; 
            padding: 10px 15px; 
            background-color: #4CAF50; 
            color: white; 
            text-decoration: none; 
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>LDAP Authentication Example</h1>
        <p>This application demonstrates LDAP authentication with Tomcat.</p>
        
        <h2>Standard Tomcat Form Authentication</h2>
        <p>
            <a href="secure/index.jsp" class="btn">Access Protected Area (Tomcat Form)</a>
        </p>
        
        <h2>Custom Java LDAP Authentication</h2>
        <p>
            <a href="customlogin.jsp" class="btn">Login with Custom LDAP (Recommended)</a>
        </p>
    </div>
</body>
</html>