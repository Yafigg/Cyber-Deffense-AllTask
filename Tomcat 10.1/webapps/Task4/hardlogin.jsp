<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Hard-coded Login</title></head>
<body>
    <h2>Hard-coded Login Test</h2>
    <p>Klik tombol untuk mencoba login dengan kredensial yang hard-coded:</p>
    
    <form action="j_security_check" method="post">
        <input type="hidden" name="j_username" value="John Fryer">
        <input type="hidden" name="j_password" value="Password123">
        <button type="submit">Login dengan Hard-coded Credentials</button>
    </form>
</body>
</html>