package com.github.dstine.alexa.example;

import com.amazon.ask.dispatcher.request.handler.HandlerInput;
import com.amazon.ask.dispatcher.request.handler.RequestHandler;
import com.amazon.ask.model.Response;

import java.util.Optional;

import static com.amazon.ask.request.Predicates.intentName;

public class GoodbyeIntentHandler implements RequestHandler {

    @Override
    public boolean canHandle(HandlerInput input) {
        return input.matches(intentName("goodbye"));
    }

    @Override
    public Optional<Response> handle(HandlerInput input) {
        String speechText = "Goodbye to all";
        return input.getResponseBuilder()
                .withSpeech(speechText)
                .withSimpleCard("Example", speechText)
                .build();
    }

}
