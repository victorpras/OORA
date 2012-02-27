package oora.cs194.berkeley.edu;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class OrderActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.order);
        
        Button store = (Button) findViewById(R.id.backButton);
		store.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						OORAActivity.class);
				startActivityForResult(myIntent, 0);
			}

		});
        
        
    }
}