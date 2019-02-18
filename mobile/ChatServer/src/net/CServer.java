package net;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class CServer extends ServerSocket implements Runnable{
	
	private int mPort;
	private List<CService> servicesList;
	public CServer(int pPort) throws IOException{
		super(pPort);
		mPort = pPort;
		servicesList = new ArrayList<CService>();
		new Thread(this).start();
	}

	@Override
	public void run() {
		try {
			while(true) {
				Socket lSocket = accept();
				servicesList.add(new CService(this,lSocket));
			}
		} catch (IOException e) {
			
		}
		
	}
	
	public void dispatchMessageToAllServices(String message){
		for(CService service : servicesList) {
			service.sendMessage(message);
		}
	}
}
