import java.net.*;
import java.io.*;

class SocketConnecteeServeurIteratif {

        static int numeroPortLocal=1234;
        static int delaiTimeOut=10000;

        public static void main(String[] args) {
                try {
                        ServerSocket socketServeur = new ServerSocket(numeroPortLocal);

                        while (true) {

                                Socket socketService = socketServeur.accept();
                                System.out.println("Connexion de la part de : "+(socketService.getInetAddress()).getHostAddress());

                                while(true){
					
                                        BufferedReader in = new BufferedReader(new InputStreamReader(socketService.getInputStream()));    
                                        String message = in.readLine();
                                        System.out.println(message);
                                        if(message.contains("-1")){
                                                socketServeur.close();
                                                break;
                                                }
                                                message=message.toUpperCase();
                                        PrintStream out = new PrintStream(socketService.getOutputStream()); 
                                        out.println(message); 	
                                }

                                socketService.close();

                        }

                }
                catch (Exception e) {
                        e.printStackTrace();
                }
        }
}
