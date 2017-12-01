import java.net.*;
import java.io.*;
import java.util.*;
import java.net.InetAddress;

class SocketConnecteeCliente {

        static String adresseIPServeur="localhost";
        static int numeroPortServeur=1234;

        public static void main(String[] args) {
                InetAddress LocaleAdresse ;
                try {

                        Socket socketCliente = new Socket();
                        LocaleAdresse = InetAddress.getLocalHost();
                        int port = InetAddress.getPort();
                        InetSocketAddress addr = new InetSocketAddress(LocaleAdresse, port);
                        System.out.println(port); 
                        /* Connexion à la socket serveur */
                        socketCliente.connect(addr);
/*
                        while(true){
                                Scanner keyboard = new Scanner(System.in);
                                System.out.print ("Votre message (finir par -1) : ");
                                String message=keyboard.nextLine();

                                BufferedReader in = new BufferedReader(new InputStreamReader(socketCliente.getInputStream())); 
                                PrintStream out = new PrintStream(socketCliente.getOutputStream()); 

                                out.println(message); 

                                if (message.equals("-1")) 
                                        break;

                                System.out.println("Votre message en majuscule : "+ in.readLine()); 

                        }
                        socketCliente.close();*/

                } 
                catch (Exception e) {
                        e.printStackTrace();
                }
        }
}

