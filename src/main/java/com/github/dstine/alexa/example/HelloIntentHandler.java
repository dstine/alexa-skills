package com.github.dstine.alexa.example;

import com.amazon.ask.dispatcher.request.handler.HandlerInput;
import com.amazon.ask.dispatcher.request.handler.RequestHandler;
import com.amazon.ask.model.Response;

import java.util.Optional;

import static com.amazon.ask.request.Predicates.intentName;

public class HelloIntentHandler implements RequestHandler {

    @Override
    public boolean canHandle(HandlerInput input) {
        return input.matches(intentName("hello"));
    }

    @Override
    public Optional<Response> handle(HandlerInput input) {
        String speechText = "Hello everyone out there";
        return input.getResponseBuilder()
                .withSpeech(speechText)
                .withSimpleCard("Example", speechText)
                .build();
    }

}
