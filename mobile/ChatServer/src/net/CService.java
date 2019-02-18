package net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class CService implements Runnable{
	Socket socket; // Socket de service , Addr-Port
	private BufferedReader br;
	private PrintWriter pw;
	private CServer server;
	
	public CService(CServer server, Socket socket) throws IOException {
		this.socket = socket;
		this.server = server;
		System.out.println("Création service");
		br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		pw = new PrintWriter(socket.getOutputStream(), true);
		new Thread(this).start();
	}
	
	@Override
	public void run() {
		try {
			while(true) {
				System.out.println("lecture message client");
				String lRequest = br.readLine();
				System.out.println("Message reçu : "+lRequest);
				
				server.dispatchMessageToAllServices(lRequest);
			}
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void sendMessage(String message) {
		System.out.println(message);
	}
}
