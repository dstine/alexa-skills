package com.github.dstine.alexa.example;

import com.amazon.ask.Skill;
import com.amazon.ask.Skills;
import com.amazon.ask.SkillStreamHandler;
import com.github.dstine.alexa.example.CancelAndStopIntentHandler;

public class ExampleStreamHandler extends SkillStreamHandler {

    private static Skill getSkill() {

        // Must be set in lambda function execution environment
        String skillId = Helpers.getEnv("ALEXA_SKILL_ID");

        return Skills.standard()
                .addRequestHandlers(
                    new LaunchRequestHandler(),
                    new HelloIntentHandler(),
                    new GoodbyeIntentHandler(),
                    new CancelAndStopIntentHandler(),
                    new SessionEndedRequestHandler()
                )
                .withSkillId(skillId)
                .build();
    }

    public ExampleStreamHandler() {
        super(getSkill());
    }
}
