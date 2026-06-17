// A minimal SynthEdit module built with the GMPI SDK: one audio input, one audio
// output, and a "Gain" parameter that scales the signal.
#include "Processor.h"

using namespace gmpi;

struct Gain final : public Processor
{
    // Audio I/O pins.
    AudioInPin  pinInput;
    AudioOutPin pinOutput;

    // A parameter pin (the knob the user turns).
    FloatInPin  pinGain;

    Gain()
    {
        // Tell the framework which member function processes audio.
        setSubProcess(&Gain::subProcess);
    }

    // Called once per audio block. Multiply the input by the gain.
    void subProcess(int sampleFrames)
    {
        auto input  = getBuffer(pinInput);
        auto output = getBuffer(pinOutput);
        const float gain = pinGain;

        for (int i = 0; i < sampleFrames; ++i)
            output[i] = gain * input[i];
    }
};

// Register the module and describe it to SynthEdit. The XML gives the module its unique
// id, display name, category, and pin list — it's how the module shows up in the editor's
// Insert menu. Keep the id stable and unique across versions.
namespace
{
auto r = Register<Gain>::withXml(R"XML(
<?xml version="1.0" encoding="utf-8" ?>
<Plugin id="SynthEdit Tutorial Gain" name="Tutorial Gain" category="Examples" vendor="SynthEdit Tutorial">
  <Parameters>
    <Parameter id="0" name="Gain" datatype="float" default="0.8"/>
  </Parameters>
  <Audio>
    <Pin name="Input"  datatype="float" rate="audio"/>
    <Pin name="Output" datatype="float" rate="audio" direction="out"/>
    <Pin parameterId="0"/>
  </Audio>
</Plugin>
)XML");
}
