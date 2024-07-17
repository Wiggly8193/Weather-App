Setting up API Key
1. Obtain an API Key: Obtain your API key from provider's website. If you already have one, skip to the next step.

2. Update setupInjection Method:
   -Open your_file.dart where setupInjection is defined.
   -Locate the method setupInjection and find the line where sl.registerSingleton<String>('YOUR_API_KEY_HERE', instanceName: 'api_key'); is defined.

3. Replace Placeholder:
	 -Replace 'YOUR_API_KEY_HERE' with your actual API key obtained in step 1.

4. Save Changes: Save the file after updating the API key.

By following these steps, you ensure that your application can access the necessary API services. For more information on how to use the API or troubleshoot issues, refer to the provider's documentation.
