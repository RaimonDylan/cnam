package main;

import java.io.IOException;

import net.CServer;

public class CMainServer {

	private static final int PORT = 40000;
	public static void main(String[] args) {
		try {
			new CServer(PORT);
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}

}
