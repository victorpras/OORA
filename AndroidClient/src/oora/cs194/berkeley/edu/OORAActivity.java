package oora.cs194.berkeley.edu;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import com.parse.Parse;
import com.parse.ParseObject;

public class OORAActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	Parse.initialize(this, "tVEZrlbL1zIiWjje6ZhE9DM5wNf7DKbMLm9hbZeP", "vKsuZD2X8oTkHHVLWTcFYS0hCF03cSVh1ocM0Y3u");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Button store = (Button) findViewById(R.id.welcomeButton);
		store.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						LoginActivity.class);
				startActivityForResult(myIntent, 0);
			}

		});
		
		Button store2 = (Button) findViewById(R.id.welcomeRest);
		store2.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						OrderActivity.class);
				startActivityForResult(myIntent, 0);
			}

		});
    }
}