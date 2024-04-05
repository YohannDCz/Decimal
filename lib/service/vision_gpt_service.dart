import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VisionService {
  Future<String> generateDescription(String imageUrl) async {
    try {
      // await dotenv.load();
      final uri = Uri.parse('https://api.openai.com/v1/chat/completions');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer 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'},
        body: jsonEncode({
          'model': 'gpt-4-vision-preview',
          'messages': [
            {
              'role': 'user',
              'content': [
                {'type': 'text', 'text': 'What’s in this image?'},
                {
                  'type': 'image_url',
                  'image_url': {
                    'url': imageUrl,
                  },
                },
              ],
            }
          ],
          'max_tokens': 50,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody['choices'][0]['message']['content'];
      } else {
        debugPrint(response.body);
        throw Exception('Failed to connect to OpenAI API');
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to connect to OpenAI API');
    }
  }
}