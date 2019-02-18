package main;

import java.io.IOException;

import net.CClient;
import net.CClientGUI;

public class CMainClient {

	public static void main(String[] args) throws IOException{
		try {
			CClient.getInstance(40000, "localhost");
		} catch (Exception e) {
		}
		new CClientGUI();
	}
}
