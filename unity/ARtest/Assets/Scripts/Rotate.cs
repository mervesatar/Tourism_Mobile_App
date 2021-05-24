using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class Rotate : MonoBehaviour, IEventSystemHandler
{
    // Start is called before the first frame update
    [SerializeField]
    Vector3 RotateAmount;

    void Start()
    {
        RotateAmount = new Vector3(0,0,0);
    }

    // Update is called once per frame
    void Update()
    {
        gameObject.transform.Rotate(RotateAmount * Time.deltaTime * 10);

        for (int i = 0; i < Input.touchCount; i++)
        {
            if (Input.GetTouch(i).phase.Equals(TouchPhase.Began))
            {
                var hit = new RaycastHit();
                Ray ray = Camera.main.ScreenPointToRay(Input.GetTouch(i).position);

                if (Physics.Raycast(ray, out hit))
                {
                    //message
                }
            }
        }
    }

    public void SetRotationSpeed(String message)
    {
        float value = float.Parse(message);
        RotateAmount = new Vector3(value, value, value);
    }
}

