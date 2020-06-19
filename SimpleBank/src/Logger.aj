import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

public aspect Logger {

    File file = new File("log.txt");
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut transaction() : call(* *.moneyMake*());
    after() : transaction() {
    	Calendar cal = Calendar.getInstance();
    	System.out.println("Depósito realizado el: "+cal.getTime());
    	writeDepositLog();
    }
	private void writeDepositLog() {
		try{
			Calendar cal = Calendar.getInstance();
			FileWriter fw = new FileWriter(file.getAbsoluteFile(), true);
	        BufferedWriter bw = new BufferedWriter(fw);
	        bw.write("Depósito realizado el: "+cal.getTime()+'\n');	
	        bw.close();
		}catch (IOException e) {
			e.printStackTrace();
		}	
	
	}
	
	pointcut usuario() : call(* *.create*(..));
    after() : usuario() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
}