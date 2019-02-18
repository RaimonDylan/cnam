package net;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class CClient extends Socket implements Runnable {
	private static CClient instance = null;
	
	private BufferedReader br;
	private PrintWriter pw;

	private CClient(int pPort, String pIPAddr) throws IOException{
		super(pIPAddr,pPort);
		br = new BufferedReader(new InputStreamReader(getInputStream()));
		pw = new PrintWriter(getOutputStream(), true);
		new Thread(this).start();
	}
	
	public static CClient getInstance(int pPort, String pIPAddr) throws IOException {
	    instance =  new CClient(pPort,pIPAddr);
		return instance;
	}
	
	public static CClient getInstance() throws IOException {
		return instance;
	}
	
	public void sendMessage(String message) {
		pw.println(message);
	}
	

	@Override
	public void run() {
	}
}
