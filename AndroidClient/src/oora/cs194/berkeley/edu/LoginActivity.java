package oora.cs194.berkeley.edu;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.Parse;
import com.parse.ParseUser;
import com.parse.ParseException;
import com.parse.LogInCallback;


public class LoginActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	Parse.initialize(this, "tVEZrlbL1zIiWjje6ZhE9DM5wNf7DKbMLm9hbZeP", "vKsuZD2X8oTkHHVLWTcFYS0hCF03cSVh1ocM0Y3u");

        super.onCreate(savedInstanceState);
        setContentView(R.layout.login);
        
        Button store = (Button) findViewById(R.id.loginButton);
		store.setOnClickListener(new View.OnClickListener() {
			public void onClick(final View view) {
				EditText userN = (EditText)findViewById(R.id.username);
				String userStr = userN.getText().toString();
				EditText pass = (EditText)findViewById(R.id.password);
				String passStr = pass.getText().toString();
				
				ParseUser.logInInBackground(userStr, passStr, new LogInCallback() {
				    public void done(ParseUser user, ParseException e) {
				        if (user != null) {
				            // Hooray! The user is logged in.
				        	Intent myIntent = new Intent(view.getContext(),
									OrderActivity.class);
							startActivityForResult(myIntent, 0);
				        } else {
				            // Signup failed. Look at the ParseException to see what happened.
				        	Context context = getApplicationContext();
				        	CharSequence text = "Something went wrong";
				        	int duration = Toast.LENGTH_SHORT;

				        	Toast toast = Toast.makeText(context, text, duration);
				        	toast.show();
				        }
				    }
				});
				
				
			}

		});
		
		TextView tv = (TextView) findViewById(R.id.text4);
		tv.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				
				Intent myIntent = new Intent(view.getContext(),
						SignupActivity.class);
				startActivityForResult(myIntent, 0);
			}

		});
        
        
    }
}