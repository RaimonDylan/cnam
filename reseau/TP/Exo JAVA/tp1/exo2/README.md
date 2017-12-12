# Exercice 2 
```java
class MonThread extends Thread {
      private String nom ;
      private int debut;
      private int max ;
      private MonThread monAutreThread;

      public MonThread(String nom, int debut, int max){
            this.nom=nom;
            this.debut=debut;
            this.max=max;
      }

      public void indicationAutreThread(MonThread monAutreThread){
            this.monAutreThread=monAutreThread;
      }

       public synchronized void run() {
      
            try {
               
                  // monAutreThread.join();

                  if (nom.equals("monThread2"))
                           monAutreThread.join(); 
                      
                  for (int i=debut;i<=max; i++){
                        System.out.println("i= "+i);
                        Thread.sleep(1000);
                  }

            }
            catch (Exception e){
                  e.printStackTrace() ;
            }
      }
}

class MesThreads {

      public static void main(String args[]){
            try{
                  MonThread monThread1=new MonThread("monThread1", 0, 50) ;
                  MonThread monThread2=new MonThread("monThread2", 51, 100);

                  monThread1.indicationAutreThread(monThread2);
                  monThread2.indicationAutreThread(monThread1);

                  monThread1.start();
                  monThread2.start();
            }
            catch (Exception e){
                  e.printStackTrace() ;
            }
      }
}

```
