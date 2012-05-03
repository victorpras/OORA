package oora.cs194.berkeley.edu;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import com.parse.Parse;
import com.parse.ParseUser;
import com.parse.ParseException;
import com.parse.SignUpCallback;


public class SignupActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
    	Parse.initialize(this, "tVEZrlbL1zIiWjje6ZhE9DM5wNf7DKbMLm9hbZeP", "vKsuZD2X8oTkHHVLWTcFYS0hCF03cSVh1ocM0Y3u");

        super.onCreate(savedInstanceState);
        setContentView(R.layout.signup);
        
        Button store = (Button) findViewById(R.id.rButton);
		store.setOnClickListener(new View.OnClickListener() {
			public void onClick(final View view) {
				EditText userN = (EditText)findViewById(R.id.username);
				String userStr = userN.getText().toString();
				EditText pass = (EditText)findViewById(R.id.password);
				String passStr = pass.getText().toString();
				
						
				ParseUser user = new ParseUser();
				user.setUsername(userStr);
				user.setPassword(passStr);
				//user.setEmail("email@example.com");

				// other fields can be set just like with ParseObject
				//user.put("phone", "650-253-0000");

				user.signUpInBackground(new SignUpCallback() {
				    public void done(ParseException e) {
				        if (e == null) {
				            // Hooray! Let them use the app now.
				        	Intent myIntent = new Intent(view.getContext(),
									LoginActivity.class);
							startActivityForResult(myIntent, 0);
				        } else {
				            // Sign up didn't succeed. Look at the ParseException
				            // to figure out what went wrong
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
        
        
    }
}