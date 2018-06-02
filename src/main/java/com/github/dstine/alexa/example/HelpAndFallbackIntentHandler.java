package com.github.dstine.alexa.example;

import com.amazon.ask.dispatcher.request.handler.HandlerInput;
import com.amazon.ask.dispatcher.request.handler.RequestHandler;
import com.amazon.ask.model.Response;

import java.util.Optional;

import static com.amazon.ask.request.Predicates.intentName;

public class HelpAndFallbackIntentHandler implements RequestHandler {

    @Override
    public boolean canHandle(HandlerInput input) {
        return input.matches(intentName("AMAZON.HelpIntent").or(intentName("AMAZON.FallbackIntent")));
    }

    @Override
    public Optional<Response> handle(HandlerInput input) {
        String speechText = "You can do various things";
        return input.getResponseBuilder()
                .withSpeech(speechText)
                .withSimpleCard("Example", speechText)
                .build();
    }
}
