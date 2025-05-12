// Simpan sebagai LdapLoginTest.java
import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;

public class LDapTest {
    public static void main(String[] args) {
        String username = "John Fryer"; // Persis seperti yang Anda masukkan di form login
        String password = "Password123";
        
        try {
            // Format DN sesuai dengan userPattern di konfigurasi
            String userDN = "cn=" + username + ",ou=people,o=SevenSeas";
            System.out.println("Mencoba login dengan DN: " + userDN);
            
            Hashtable<String, String> env = new Hashtable<>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, "ldap://localhost:10389");
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, userDN);
            env.put(Context.SECURITY_CREDENTIALS, password);
            
            DirContext ctx = new InitialDirContext(env);
            System.out.println("Login berhasil!");
            ctx.close();
        } catch (Exception e) {
            System.out.println("Login gagal: " + e.getMessage());
            e.printStackTrace();
        }
    }
}