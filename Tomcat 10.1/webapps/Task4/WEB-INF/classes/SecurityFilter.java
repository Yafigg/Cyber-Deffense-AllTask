import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/secure/*")
public class SecurityFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        boolean isAuthenticated = session != null && 
                                 session.getAttribute("authenticated") != null && 
                                 (Boolean) session.getAttribute("authenticated");
                                 
        boolean hasUserRole = session != null && 
                             "user".equals(session.getAttribute("userRole"));
        
        if (isAuthenticated && hasUserRole) {
            chain.doFilter(request, response);
        } else {
            // Not authenticated - redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/customlogin.jsp");
        }
    }
    
    @Override
    public void destroy() {}
}