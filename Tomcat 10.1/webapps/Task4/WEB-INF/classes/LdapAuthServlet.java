import java.io.IOException;
import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ldapLogin")
public class LdapAuthServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required");
            request.getRequestDispatcher("/customlogin.jsp").forward(request, response);
            return;
        }
        
        try {
            // Format DN sesuai dengan userPattern di konfigurasi
            String userDN = "cn=" + username + ",ou=people,o=SevenSeas";
            System.out.println("Attempting authentication with DN: " + userDN);
            
            Hashtable<String, String> env = new Hashtable<>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, "ldap://localhost:10389");
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, userDN);
            env.put(Context.SECURITY_CREDENTIALS, password);
            
            DirContext ctx = new InitialDirContext(env);
            System.out.println("LDAP Authentication successful for user: " + username);
            
            // Set user as authenticated, bypass role check
            HttpSession session = request.getSession();
            session.setAttribute("authenticated", true);
            session.setAttribute("username", username);
            session.setAttribute("userRole", "user");
            
            // Redirect to secure area
            response.sendRedirect(request.getContextPath() + "/secure/index.jsp");
            
            // Close LDAP connection
            ctx.close();
            
        } catch (NamingException e) {
            System.out.println("LDAP Authentication failed: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/customlogin.jsp").forward(request, response);
        }
    }
    
    // Metode ini tidak lagi digunakan karena kita bypass pengecekan role
    private boolean checkUserRole(DirContext ctx, String username) {
        try {
            System.out.println("Checking role for user: " + username);
            
            // Mengembalikan true secara langsung untuk bypass pengecekan role
            return true;
            
        } catch (Exception e) {
            System.out.println("Error during role check: " + e.getMessage());
            e.printStackTrace();
            return true; // Return true even if error occurs
        }
    }
}